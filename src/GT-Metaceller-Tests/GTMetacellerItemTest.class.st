Class {
	#name : #GTMetacellerItemTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerItemTest >> testItemChangeUsingSpec [
	| mainProject item1 item2 |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	item1 := (mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-Streams'.
	item1 saveWithSpecString: 'aSpec
		package: ''GT-Metaceller-Streams'''.
	self assert: item1 requires size equals: 1.
	item1 childVersions do: [ :each |
		self assert: each requires size equals: 1 ].
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	item2 := (mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-Streams'.
	self assert: item2 requires size equals: 0.
	item2 childVersions do: [ :each |
		self assert: each requires size equals: 0 ]
]
