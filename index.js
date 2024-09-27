require('dotenv').config();
const sql=require("mysql2");
const cors=require("cors");
const express=require("express");
const api=express();
const { generateToken, verifyToken, encrypt } = require('./jwt');

api.use(cors({origin: "http://localhost:3000", credentials: true}));
api.use(express.json());
api.use("/img",express.static("img"));

const authJWT = (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
        return res.status(401).send('Access denied. No token provided.');
    }
    verifyToken(token, (err, decoded) => {
        if (err) {
            return res.status(400).send('Invalid token.');
        }
        req.user = decoded;
        next();
    });
};
const apiDB = sql.createPool({
    host: process.env.SQL_HOST,
    user: process.env.SQL_USER,
    password: process.env.SQL_PASSWORD,
    database: process.env.SQL_DATABASE,
    port: process.env.SQL_PORT,
    connectionLimit: process.env.SQL_CONNECTION_LIMIT
});


api.post("/register", (req, res) => {
    const { firstName, lastName, username, email, password } = req.body;
    console.log('Received registration request:', req.body);
    encrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Error hashing password:', err);
        }

        apiDB.query(
            "INSERT INTO Customer (UserName, Password, FirstName, LastName, Email) VALUES (?, ?, ?, ?, ?)",
            [username, hashedPassword, firstName, lastName, email],
            (err, result) => {
                if (err) {
                    console.error('Error inserting into database:', err);
                }
                res.status(201).send(`Customer created with ID: ${result.insertId}`);
            }
        );
    });
});

api.post("/login", (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) {
        return res.status(400).send('Username and password are required.');
    }
    apiDB.query("SELECT * FROM Customer WHERE UserName = ?", [username], (err, results) => {
        if (err) return res.status(500).send('Server error');
        if (results.length === 0) return res.status(400).send('Invalid username or password');

        const user = results[0];
        encrypt.compare(password, user.Password, (err, validPassword) => {
            if (err) return res.status(500).send('Server error');
            if (!validPassword) return res.status(400).send('Invalid username or password');

            generateToken(user, (err, token) => {
                if (err) return res.status(500).send('Error generating token');
                res.status(200).send({ token });
            });
        });
    });
});

api.get("/user/logindata", authJWT, (req, res) => {
    apiDB.query("SELECT UserName, FirstName, LastName, Email FROM Customer WHERE ID=?",req.user.id, (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).json(result[0]);
    });
});
api.patch("/user/update", authJWT, (req, res) => {
    const { firstName, lastName, email } = req.body;
    apiDB.query("UPDATE Customer SET FirstName=?, LastName=?, Email=? WHERE ID=?", [firstName, lastName, email, req.user.id], (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).send('User updated');
    });
});
api.patch("/user/password", authJWT, (req, res) => {
    const { password } = req.body;
    encrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) return res.status(500).send('Server error');
        apiDB.query("UPDATE Customer SET Password=? WHERE ID=?", [hashedPassword, req.user.id], (err, result) => {
            if (err) return res.status(500).send('Server error');
            res.status(200).send('Password updated');
        });
    });
});
api.delete("/user/delete", authJWT, (req, res) => {
    apiDB.query("DELETE FROM Customer WHERE ID=?", req.user.id, (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).send('User deleted');
    });
});
api.get("address", authJWT, (req, res) => {
    apiDB.query("SELECT * FROM Address WHERE CustomerID=?", req.user.id, (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).json(result);
    });
});
api.post("/address", authJWT, (req, res) => {
    const { address, city, PostCode, country } = req.body;
    apiDB.query("INSERT INTO Address (Address, City, PostCode, Country, CustomerID) VALUES (?, ?, ?, ?, ?)", [address, city, PostCode, country, req.user.id], (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(201).send('Address added');
    });
});
api.get("/orders", authJWT, (req, res) => {
    apiDB.query("SELECT * FROM Orders WHERE CustomerID=?", req.user.id, (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).json(result);
    });
});
api.get("/PaymentMethods", authJWT, (req, res) => {
    apiDB.query("SELECT * FROM PaymentMethods WHERE CustomerID=?", req.user.id, (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(200).json(result);
    });
});
api.post("/PaymentMethods", authJWT, (req, res) => {
    const { paymentProvider, billingAccount, expiryDate } = req.body;
    apiDB.query("INSERT INTO PaymentMethods (PaymentProviderID, BillingAccount, ExpiryDate, CustomerID) VALUES (?, ?, ?, ?)", [paymentProvider,billingAccount,expiryDate,req.user.id], (err, result) => {
        if (err) return res.status(500).send('Server error');
        res.status(201).send('Payment method added');
    });
});
api.get("/categories", (req, res) => {
    apiDB.query("SELECT * FROM Categories WHERE ID >2;", (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving categories");
            return;
        }
        res.status(200).json(results);
    });
});
api.get("/categories/:id", (req, res) => {
    const {id}= req.params;
    apiDB.query("SELECT p.Name AS ProductName,\n" +
        "       p.Price AS ProductPrice,\n" +
        "       p.Thumb AS ProductThumbnail,\n" +
        "       p.Description AS ProductDescription,\n" +
        "       i.Quantity AS ProductStock,\n" +
        "       m.Name AS ProductManufacturer,\n" +
        "       c.Thumb AS CategoryThumbnail,\n" +
        "       (SELECT GROUP_CONCAT(c2.Name SEPARATOR ', ')\n" +
        "        FROM Categories c2\n" +
        "                 JOIN ProductCategories pc2 ON c2.ID = pc2.CategoryID\n" +
        "        WHERE pc2.ProductID = p.ID) AS Categories\n" +
        "FROM Product p\n" +
        "         JOIN ProductCategories pc ON p.ID = pc.ProductID\n" +
        "         JOIN Manufacturer m ON p.ManufacturerID = m.ID\n" +
        "         JOIN Inventory i ON p.ID = i.ProductID\n" +
        "         JOIN Categories c ON pc.CategoryID = c.ID\n" +
        "WHERE pc.CategoryID = ?;",[id], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving category");
            return;
        }
        res.status(200).json(results);
    });
});
api.get("/search/categories", (req, res) => {
    apiDB.query("SELECT Name,ID FROM Categories;", (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving categories");
            return;
        }
        res.status(200).json(results);
    });
});
api.get("/search/products", (req, res) => {
    apiDB.query("SELECT p.Name AS ProductName,\n" +
        "       p.Price AS ProductPrice,\n" +
        "       p.Thumb AS ProductThumbnail,\n" +
        "       p.Description AS ProductDescription,\n" +
        "       i.Quantity AS ProductStock,\n" +
        "       m.Name AS ProductManufacturer,\n" +
        "       c.Thumb AS CategoryThumbnail,\n" +
        "       (SELECT GROUP_CONCAT(c2.ID SEPARATOR ', ')\n" +
        "        FROM Categories c2\n" +
        "                 JOIN ProductCategories pc2 ON c2.ID = pc2.CategoryID\n" +
        "        WHERE pc2.ProductID = p.ID) AS Categories\n" +
        "FROM Product p\n" +
        "         JOIN ProductCategories pc ON p.ID = pc.ProductID\n" +
        "         JOIN Manufacturer m ON p.ManufacturerID = m.ID\n" +
        "         JOIN Inventory i ON p.ID = i.ProductID\n" +
        "         JOIN Categories c ON pc.CategoryID = c.ID WHERE pc.CategoryID > 2;", (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving products");
            return;
        }
        res.status(200).json(results);
    });
});
api.listen(4390, () => {
    console.log("Server running on port 4390");
});