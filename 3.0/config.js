conn = new Mongo();
db = conn.getDB('landsat-api');
db.test.insert({test: 'test'});

db.createUser(
  {
    user: username,
    pwd: password,
    roles:[
      {
        role:'readWrite',
        db: databaseName
      }
    ]
  }
);

db.test.drop();
