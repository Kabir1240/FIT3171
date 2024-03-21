// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T3-mns-mongo.mongodb.js

//Student ID: 30032067
//Student Name: Kabir Kashif
//Unit Code: FIT3171
//Applied Class No: 03

//Comments for your marker:

// ===================================================================================
// Do not modify or remove any of the comments in this document (items marked with //)
// ===================================================================================

//Use (connect to) your database - you MUST update xyz001
//with your authcate username

use("kkas0007");

// 3(b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Drop collection 
db.myCollection.drop()

// Create collection and insert documents
// db.createCollection('myCollection');

db.myCollection.insertMany(
    [
        {"_id":1,"datetime":"08-09-2023 10:00","provider_code":"ORS001","provider_name":"Dr. Jessica Jones","item_totalcost":160,"no_of_items":4,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1}]},
        {"_id":3,"datetime":"08-09-2023 12:00","provider_code":"ORS001","provider_name":"Dr. Jessica Jones","item_totalcost":135,"no_of_items":10,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":5},{"id":15,"desc":"Absorbable suture","standardcost":3,"quantity":2},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":1},{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":10},{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":1},{"id":1,"desc":"Paper tips","standardcost":1,"quantity":5},{"id":15,"desc":"Absorbable suture","standardcost":3,"quantity":2},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":1},{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":10},{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":1}]},
        {"_id":5,"datetime":"08-09-2023 16:00","provider_code":"GEN001","provider_name":"Dr. Bruce Striplin","item_totalcost":75,"no_of_items":3,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1}]},
        {"_id":7,"datetime":"08-09-2023 12:00","provider_code":"GEN002","provider_name":"Dr. Amalia Morris","item_totalcost":78,"no_of_items":2,"items":[{"id":18,"desc":"Fluid composite","standardcost":78,"quantity":1},{"id":18,"desc":"Fluid composite","standardcost":78,"quantity":1}]},
        {"_id":8,"datetime":"08-09-2023 12:00","provider_code":"END001","provider_name":"Dr. Mark Stanton","item_totalcost":78,"no_of_items":6,"items":[{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":1},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":1},{"id":6,"desc":"Universal Clamp","standardcost":15,"quantity":1},{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":1},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":1},{"id":6,"desc":"Universal Clamp","standardcost":15,"quantity":1}]},
        {"_id":9,"datetime":"11-09-2023 15:00","provider_code":"ORS001","provider_name":"Dr. Jessica Jones","item_totalcost":5,"no_of_items":1,"items":[{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":10}]},
        {"_id":10,"datetime":"11-09-2023 09:15","provider_code":"PER002","provider_name":"Dr. Joseph Hazelton","item_totalcost":16,"no_of_items":2,"items":[{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":1},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":1}]},
        {"_id":11,"datetime":"11-09-2023 15:00","provider_code":"PED002","provider_name":"Dr. Lee","item_totalcost":160,"no_of_items":8,"items":[{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1},{"id":20,"desc":"Phospor imaging plate","standardcost":75,"quantity":1},{"id":21,"desc":"Clinasept Film","standardcost":5,"quantity":1}]},
        {"_id":18,"datetime":"14-09-2023 10:00","provider_code":"PER001","provider_name":"Dr. April Manahan","item_totalcost":20,"no_of_items":2,"items":[{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":1},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":2}]},
        {"_id":19,"datetime":"14-09-2023 14:00","provider_code":"END001","provider_name":"Dr. Mark Stanton","item_totalcost":180,"no_of_items":6,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":5},{"id":16,"desc":"Universal composite","standardcost":48,"quantity":1},{"id":5,"desc":"Sterile K NiTi files","standardcost":7,"quantity":1},{"id":1,"desc":"Paper tips","standardcost":1,"quantity":5},{"id":16,"desc":"Universal composite","standardcost":48,"quantity":1},{"id":5,"desc":"Sterile K NiTi files","standardcost":7,"quantity":1}]},
        {"_id":20,"datetime":"14-09-2023 09:00","provider_code":"PED001","provider_name":"Dr. Kevin Barr","item_totalcost":120,"no_of_items":4,"items":[{"id":22,"desc":"Porcelain Etch","standardcost":35,"quantity":1},{"id":23,"desc":"Silane","standardcost":25,"quantity":1},{"id":22,"desc":"Porcelain Etch","standardcost":35,"quantity":1},{"id":23,"desc":"Silane","standardcost":25,"quantity":1}]},
        {"_id":22,"datetime":"14-09-2023 10:00","provider_code":"ORT001","provider_name":"Dr. Gerry Elliott","item_totalcost":280,"no_of_items":8,"items":[{"id":9,"desc":"Metal Bracket","standardcost":1.5,"quantity":20},{"id":12,"desc":"Curved lingual button","standardcost":1,"quantity":8},{"id":11,"desc":"Archwire","standardcost":2,"quantity":4},{"id":10,"desc":"Molar mouth tube","standardcost":2,"quantity":12},{"id":9,"desc":"Metal Bracket","standardcost":1.5,"quantity":20},{"id":12,"desc":"Curved lingual button","standardcost":1,"quantity":8},{"id":11,"desc":"Archwire","standardcost":2,"quantity":4},{"id":10,"desc":"Molar mouth tube","standardcost":2,"quantity":12}]}
    ]
);

// List all documents you added
db.myCollection.find({});

// 3(c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.myCollection.find(
    {"$or":[{"item_totalcost":{"$gt":50}}, {"no_of_items":{"$gt":2}}]}
);


// 3(d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.myCollection.updateMany(
    {
        "items.id": 1,
    },
    {
        "$set":
        {
            "items.$.desc":"Paper Points"
        }
    }
);

// Illustrate/confirm changes made
db.myCollection.find({"items.id":1});

// 3(e)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
use('kkas0007')

db.myCollection.updateOne(
    {
        "_id": 20,
    },
    {"$push":
        {
            "items":
            {
                "id": 3,
                "desc":"EDTA Cleansing Gel 17%",
                "standardcost":8,
                "quantity":1
            },
        }
    }
);
db.myCollection.updateOne(
    {
        "_id": 20,
    },
    {"$push":
        {
            "items":
            {
                "id": 4,
                "desc":"‘Irrigation Solution 2% Chlorhexidine",
                "standardcost":9,
                "quantity":1
            },
        }
    }
);
db.myCollection.updateOne(
    {
        "_id": 20,
    },
    {"$push":
        {
            "items":
            {
                "id": 8,
                "desc":"‘Irrigation Needle and Syringe",
                "standardcost":2,
                "quantity":2
            },
        }
    }
);

// Illustrate/confirm changes made
db.myCollection.find({"_id":20});