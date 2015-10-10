Class {
	#name : #GlobalIdentifierFuelPersistence,
	#superclass : #GlobalIdentifierPersistence,
	#category : #'GT-EventRecorder-Identifiers'
}

{ #category : #configuration }
GlobalIdentifierFuelPersistence >> fileName [ 
	^ 'org.pharo.gt.spotter.event.recorder.fuel'
]

{ #category : #'load and saving' }
GlobalIdentifierFuelPersistence >> load [
	^ FLMaterializer materializeFromFileNamed: self preferences
]

{ #category : #'load and saving' }
GlobalIdentifierFuelPersistence >> save: aDictionary into: aWriteStream [
	aWriteStream binary.
	[ FLSerializer serialize: aDictionary on: aWriteStream ]
		on: Error
		do: [ :anError | "ignore" ]
]
