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
		'variableBindings',
		'mustDeclareVariables'
	],
	#category : #'GT-Playground'
}

{ #category : #binding }
GTPlaygroundContext >> bindingOf: aString [ 

	mustDeclareVariables ifTrue: [^ nil].
	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	variableBindings  ifNil: [self initializeBindings].
	(variableBindings includesKey: aString)
		ifFalse: [variableBindings at: aString put: nil].
	^ variableBindings associationAt: aString
]

{ #category : #binding }
GTPlaygroundContext >> browseBindings [

	variableBindings inspect
]

{ #category : #initialization }
GTPlaygroundContext >> initialize [

	super initialize.
	mustDeclareVariables := false.
]

{ #category : #initialization }
GTPlaygroundContext >> initializeBindings [
	
	variableBindings := Dictionary new
]

{ #category : #accessing }
GTPlaygroundContext >> setBindings: aDictionary [

	variableBindings := aDictionary.

]
