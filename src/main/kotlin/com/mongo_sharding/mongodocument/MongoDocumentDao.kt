package com.mongo_sharding.mongodocument

import org.springframework.data.mongodb.repository.MongoRepository

interface MongoDocumentDao : MongoRepository<MongoDocument, String>
