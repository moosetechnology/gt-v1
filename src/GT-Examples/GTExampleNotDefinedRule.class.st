"
Every class that defines a custom extension for GTSpotter or GTInspector should define also, at least, a GTExample.
"
Class {
	#name : #GTExampleNotDefinedRule,
	#superclass : #RBBlockLintRule,
	#category : #'GT-Examples-Testing'
}

{ #category : #testing }
GTExampleNotDefinedRule class >> checksClass [
	^ true
]

{ #category : #accessing }
GTExampleNotDefinedRule class >> uniqueIdentifierName [
	"This number should be unique and should change only when the rule completely change semantics"
	
	^'GTExampleNotDefinedRule'
]

{ #category : #running }
GTExampleNotDefinedRule >> basicCheck: aClass [ 
	^ (self containsCustomExtension: aClass) 
		and: [ (self containsGTExample: aClass) not ]
]

{ #category : #private }
GTExampleNotDefinedRule >> check: aClass forCriticsDo: aCriticBlock ifNone: alternativeBlock [
	(self basicCheck: aClass)
		ifTrue:  [ aCriticBlock cull: (
			(ReMissingMethodCritic
				for: aClass
				by: self
				class: aClass class
				selector: #gtExample) beShouldBeImplemented )  ]
		ifFalse: alternativeBlock 
]

{ #category : #running }
GTExampleNotDefinedRule >> checkClass: aClass [ 
	(self basicCheck: aClass) ifTrue: [
		result
			addClass: aClass ]
]

{ #category : #running }
GTExampleNotDefinedRule >> containsCustomExtension: aClass [

	^ aClass methods anySatisfy: [:aMethod | 
		aMethod pragmas anySatisfy: [ :aPragma |
			aPragma keyword = GTInspector extensionsPragma or: [
				aPragma keyword = GTSpotter extensionsPragma ]]]
]

{ #category : #running }
GTExampleNotDefinedRule >> containsGTExample: aClass [

	^ aClass class methods anySatisfy: [:aMethod | 
			aMethod pragmas 
				anySatisfy: [ :pragma | pragma isGTExamplePragma ]]
]

{ #category : #accessing }
GTExampleNotDefinedRule >> group [
	^ 'Design Flaws'
]

{ #category : #accessing }
GTExampleNotDefinedRule >> name [
	^ 'Class defines a custom GT extension but no example'
]

{ #category : #accessing }
GTExampleNotDefinedRule >> resultClass [
	^ RBClassEnvironment
]

{ #category : #accessing }
GTExampleNotDefinedRule >> severity [
	^ #information
]
