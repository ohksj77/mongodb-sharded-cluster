package com.mongo_sharding.mongodocument

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("documents")
class MongoDocumentController(
    private val mongoDocumentDao: MongoDocumentDao
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    fun createDocument(@RequestBody document: MongoDocument): String =
        mongoDocumentDao.save(document).id

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    fun getDocuments(): List<MongoDocument> =
        mongoDocumentDao.findAll()
}
