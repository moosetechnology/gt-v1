Class {
	#name : #RTExampleMethodIcon,
	#superclass : #GTAbstractExampleMethod,
	#traits : 'TGTExampleIcon',
	#classTraits : 'TGTExampleIcon classTrait',
	#category : #'GT-Examples-TODO'
}

{ #category : #private }
RTExampleMethodIcon >> basicForm [
	| iconSelector iconProvider icon64Mime |
	iconSelector := (self selector, 'Icon') asSymbol.
	((iconProvider := self provider) class canPerform: iconSelector) ifFalse: [ ^ nil ].
	icon64Mime := [ iconProvider perform: iconSelector ]
		on: Error
		do: [ ^ nil ].
	^ [ TRPlatform current formClass fromBinaryStream: 
			(TRPlatform current mimeDecodeToBytes: icon64Mime readStream) ]
		on: Error
		do: [ nil ]
]

{ #category : #testing }
RTExampleMethodIcon >> exists [
	^ super exists
		and: [ self methodClass includesSelector: (self selector, 'Icon') asSymbol ]
]