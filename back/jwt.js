const jwt=require('jsonwebtoken');
const encrypt=require('bcrypt');

const generateToken=(user,callback) => {
    const data={ id: user.ID};
    jwt.sign(data, process.env.JWT_SECRET, { expiresIn: '1h' }, callback);
};

const verifyToken=(token, callback) => {
    jwt.verify(token, process.env.JWT_SECRET, callback);
};

module.exports={generateToken,verifyToken,encrypt };