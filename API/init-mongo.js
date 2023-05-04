db.createUser({
    user: "admin",
    pwd: "admin",
    roles: [
        {
            role: "readWrite",
            db: "hotels"
        }
    ]
});

db.createCollection("hotels");



