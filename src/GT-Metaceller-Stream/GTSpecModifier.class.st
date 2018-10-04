Class {
	#name : #GTSpecModifier,
	#superclass : #Object,
	#instVars : [
		'item'
	],
	#category : #'GT-Metaceller-Stream'
}

{ #category : #'instance creation' }
GTSpecModifier class >> on: anItem [
	^self new
		item: anItem;
		yourself
]

{ #category : #'code generation' }
GTSpecModifier >> group: aString [ 
	(self item isGroup and: [ self item itemName = aString ]) 
		ifFalse: [ self item: (self item createGroupWithName: aString) ]
]

{ #category : #'code generation' }
GTSpecModifier >> group: aString with: aStringOrCollection [
	(self item isGroup and: [ self item itemName = aString ]) 
		ifFalse: [ self item: (self item createGroupWithName: aString) ].
	self item includes: aStringOrCollection
]

{ #category : #accessing }
GTSpecModifier >> item [
	^ item
]

{ #category : #accessing }
GTSpecModifier >> item: anObject [
	item := anObject
]

{ #category : #doit }
GTSpecModifier >> method [
	^GTSpecModifier methodDictionary at: #method
]

{ #category : #doit }
GTSpecModifier >> namedTempAt: anInteger [ 
	^self
]

{ #category : #'code generation' }
GTSpecModifier >> package: aString [ 
	(self item isPackage and: [ self item itemName = aString ]) 
		ifFalse: [ self item: (self item createPackageWithName: aString) ]
]

{ #category : #'code generation' }
GTSpecModifier >> package: aString with: aBlockOrString [
	aBlockOrString setPackage: aString withInMetacelloConfig: self
]

{ #category : #'code generation' }
GTSpecModifier >> project: aString [
	(self item isProject and: [ self item itemName = aString ]) 
		ifFalse: [ self item: (self item createProjectWithName: aString) ]
]

{ #category : #'code generation' }
GTSpecModifier >> project: aString with: aBlockOrString [
	aBlockOrString setProject: aString withInMetacelloConfig: self
]

{ #category : #'code generation' }
GTSpecModifier >> setPackage: aName withBlock: aBlock [
	(self item isPackage and: [ self item itemName = aName ]) 
		ifFalse: [ self item: (self item createPackageWithName: aName) ].
	aBlock value
]

{ #category : #'code generation' }
GTSpecModifier >> setPackage: aName withString: aString [
	(self item isPackage and: [ self item itemName = aName ]) 
		ifFalse: [ self item: (self item createPackageWithName: aName) ].
	self item file: aString
]

{ #category : #'code generation' }
GTSpecModifier >> setProject: aName withBlock: aBlock [
	(self item isProject and: [ self item itemName = aName ]) 
		ifFalse: [ self item: (self item createProjectWithName: aName) ].
	aBlock value
]

{ #category : #'code generation' }
GTSpecModifier >> setProject: aName withString: aStringOrNil [
	(self item isProject and: [ self item itemName = aName ]) 
		ifFalse: [ self item: (self item createProjectWithName: aName) ].
	self item versionString: aStringOrNil
]

{ #category : #doit }
GTSpecModifier >> tempNames [
	^#( 'aSpec' )
]
