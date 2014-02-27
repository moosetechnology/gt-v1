"
I am context  that only holds a collection of binings.  I provide no bindings for temporary variables. 
Because I do not provide any bindings for temporary variables, any time an undeclared variable
is encountered it will be added to my list of binginds. For this to work properly I have to be set as
the requestor of the compiler.

|context|
context := GTPlaygroundContext new.
nil class compiler
		source: 'a:=1. b:=2. c:=a+b. c';
		context: nil; ""context used to lookup variables; if nil no lookup is done""
		receiver: nil;
		requestor: context;
		failBlock:  [ ^ nil];
		evaluate.
context browseBindings.	""three bindings are present""
"
Class {
	#name : #GTPlaygroundContext,
	#superclass : #Object,
	#instVars : [
		'variableBindings'
	],
	#category : #'GT-Playground'
}

{ #category : #binding }
GTPlaygroundContext >> bindingOf: aString [ 

	variableBindings ifNil: [self initializeBindings].
	(variableBindings includesKey: aString)
		ifFalse: [variableBindings at: aString put: nil].
	^ variableBindings associationAt: aString
]

{ #category : #accessing }
GTPlaygroundContext >> bingings [

	^ variableBindings associations collect: [ :each| each key -> each value ]
]

{ #category : #binding }
GTPlaygroundContext >> browseBindings [

	variableBindings inspect
]

{ #category : #initialization }
GTPlaygroundContext >> initialize [

	super initialize.
	self initializeBindings.
]

{ #category : #initialization }
GTPlaygroundContext >> initializeBindings [
	
	variableBindings := Dictionary new.
]

{ #category : #accessing }
GTPlaygroundContext >> setBindings: aDictionary [

	variableBindings := aDictionary.

]
