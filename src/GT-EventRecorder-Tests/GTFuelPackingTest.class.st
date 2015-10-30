Class {
	#name : #GTFuelPackingTest,
	#superclass : #GTEventPackingTest,
	#category : #'GT-EventRecorder-Tests-Core'
}

{ #category : #accessing }
GTFuelPackingTest >> packingClass [
	^ GTFuelPacking
]

{ #category : #tests }
GTFuelPackingTest >> testMigration [
	| oldClass oldObject collector bundle announcement |
	oldClass := Object newAnonymousSubclass.
	oldObject := oldClass new.
	collector := GTEventCollector new.
	collector add: oldObject.
	bundle := packing pack: collector.
	announcement := packing unpack: bundle data.
	self should: [ announcement unpackedData ] raise: FLClassNotFound.
]

{ #category : #tests }
GTFuelPackingTest >> testMigration2 [
	| oldClass oldObject collector bundle announcement unpackedData |
	oldClass := Object newAnonymousSubclass.
	oldObject := oldClass new.
	collector := GTEventCollector new.
	collector add: oldObject.
	bundle := packing pack: collector.
	packing addMigration: [ :aMaterializer |
		aMaterializer migrateClassNamed: oldClass name asSymbol toClass: GTDummyEvent ].
	announcement := packing unpack: bundle data.
	announcement migrationRules: packing migrations.
	unpackedData := announcement unpackedData.
	self assert: unpackedData isCollection.
	self assert: unpackedData size equals: 1.
	self assert: unpackedData any class equals: GTDummyEvent.
]
