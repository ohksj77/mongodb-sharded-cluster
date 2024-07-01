package com.mongo_sharding

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class MongoShardingApplication

fun main(args: Array<String>) {
	runApplication<MongoShardingApplication>(*args)
}
