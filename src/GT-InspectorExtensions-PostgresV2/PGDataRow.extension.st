Extension { #name : #PGDataRow }

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> atName: aSymbol [

	^self at: (dictionary at: aSymbol)
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> atName: aSymbol ifAbsent: aBlock [

	^self at: (dictionary 
		at: aSymbol
		ifAbsent: [ ^aBlock value ])
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> dictionary: anIdentityDictionary [

	dictionary := anIdentityDictionary 
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> doesNotUnderstand: aMessage [

	^self at: (
		dictionary 
			at: aMessage selector
			ifAbsent: [ ^super doesNotUnderstand: aMessage ])
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> gtInspectorValuesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite table
		title: 'Values';
		display: [ self dictionary keys ];
		column: 'Name' evaluated: [ :each | each ];
		column: 'Value' evaluated: [ :each | self atName: each ]	
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> indexOf: aSymbol [

	^dictionary at: aSymbol ifAbsent: 0
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> name [

	^self atName: #name
]

{ #category : #'*GT-InspectorExtensions-PostgresV2' }
PGDataRow >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	(dictionary associations
		sort: [ :a :b | a value < b value ])
		do: [ :assoc |
			aStream 
				nextPutAll: assoc key;
				nextPutAll: ': ';
				print: (self at: assoc value) ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPut: $)
]
