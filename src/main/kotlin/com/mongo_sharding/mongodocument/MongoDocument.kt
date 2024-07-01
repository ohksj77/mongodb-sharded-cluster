package com.mongo_sharding.mongodocument

import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document
import java.util.*

@Document(collection = "testcollection")
class MongoDocument(
    val data: String?
) {
    @Id
    var id: String = UUID.randomUUID().toString()
        protected set
}
