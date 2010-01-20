Class {
	#name : #GTSTBehavior,
	#superclass : #GTSTNamedModel,
	#instVars : [
		'stBehavior',
		'instanceAndMetaMethods',
		'methods',
		'instVars'
	],
	#category : #'GT-Model'
}

{ #category : #'instance creation' }
GTSTBehavior class >> behavior: aBehavior environment: anEnvironment [
	^ self new
		stBehavior: aBehavior;
		environment: anEnvironment;
		yourself
]

{ #category : #accessing }
GTSTBehavior >> comment [
	^ self stBehavior comment
]

{ #category : #accessing }
GTSTBehavior >> definition [
	^ self stBehavior definition
]

{ #category : #accessing }
GTSTBehavior >> glmPackage [
	^ GTSTPackage named: (PackageOrganizer default mostSpecificPackageOfClass: self stBehavior) packageName environment: self environment
]

{ #category : #accessing }
GTSTBehavior >> instVars [
	^ instVars ifNil: [
		instVars := self stBehavior instVarNames collect: [:each | 
			GTSTVariable new name: each; glmBehavior: self; yourself ] ]
]

{ #category : #accessing }
GTSTBehavior >> instanceAndMetaMethods [
	^ instanceAndMetaMethods ifNil: [ instanceAndMetaMethods := (self methods, self metaSide methods) asSortedCollection: [:a :b | a name < b name] ]
]

{ #category : #testing }
GTSTBehavior >> isMetaSide [ 
	^ self stBehavior class = Metaclass 
]

{ #category : #accessing }
GTSTBehavior >> metaSide [
	^ (GTSTClass named: self name) 
		stBehavior: self stBehavior class;
		yourself
]

{ #category : #accessing }
GTSTBehavior >> methods [
	^ methods ifNil: [
		methods := OrderedCollection new.
		self protocols do: [:each |
			methods addAll: each methods ].
		methods ]
]

{ #category : #accessing }
GTSTBehavior >> name [
	^ self stBehavior name
]

{ #category : #accessing }
GTSTBehavior >> protocols [
	^ (self environment protocolsFor: self stBehavior) collect: 
		[ :each | 
		GTSTProtocol new
			name: each;
			glmBehavior: self;
			yourself ]
]

{ #category : #accessing }
GTSTBehavior >> references [
	| association |
	association := Smalltalk associationAt: self name ifAbsent: [ ^ #() ].
	^ (self systemNavigation allCallsOn: association) collect: [ :each |
		GTSTMethod fromMethodReference: each ]
]

{ #category : #accessing }
GTSTBehavior >> sourceCodeAt: aSelector [
	^ self stBehavior sourceCodeAt: aSelector
]

{ #category : #accessing }
GTSTBehavior >> stBehavior [
	^ stBehavior
]

{ #category : #accessing }
GTSTBehavior >> stBehavior: anObject [
	stBehavior := anObject
]

{ #category : #accessing }
GTSTBehavior >> traits [
	^ self stBehavior traitComposition traits collect: [:each |
		GTSTTrait new stBehavior: each; yourself]
]
