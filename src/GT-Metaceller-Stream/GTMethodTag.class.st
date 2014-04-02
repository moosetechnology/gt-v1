Class {
	#name : #GTMethodTag,
	#superclass : #GTStatementListTag,
	#category : #'GT-Metaceller-Stream'
}

{ #category : #generating }
GTMethodTag >> method: aMethodName version: aVersionName importedVersions: aCollection [ 
	self stream nextPutAll: aMethodName; nextPutAll: ' aSpec'; cr;
		tab; nextPutAll: '<version: '.
	aVersionName asCodeStringOn: self stream.
	aCollection ifNotEmpty: [ 
		self stream nextPutAll: ' imports: '.
		aCollection asCodeStringOn: self stream ].
	self stream nextPut: $>
]

{ #category : #convenience }
GTMethodTag >> methodNameFor: aString [
	(aString endsWith: 'baseline') ifTrue: [ 
		^(('baseline', (aString copyFrom: 1 to: (aString size-8))) asLegalSelector), ':' ].
	^('version', aString) asLegalSelector, ':'
]

{ #category : #generating }
GTMethodTag >> version: aString importedVersions: aCollection [ 
	self method: (self methodNameFor: aString) version: aString importedVersions: aCollection
]
