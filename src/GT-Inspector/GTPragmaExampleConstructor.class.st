Class {
	#name : #GTPragmaExampleConstructor,
	#superclass : #GTExampleConstructor,
	#instVars : [
		'pragmaKeyword'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #'instance creation' }
GTPragmaExampleConstructor class >> for: aPragmaKeyword [

	^ self new pragmaKeyword: aPragmaKeyword
]

{ #category : #testing }
GTPragmaExampleConstructor >> appliesTo: aMethod [

	^ aMethod pragmas anySatisfy: [ :aPragma | aPragma keyword = self pragmaKeyword ]
]

{ #category : #'example creation' }
GTPragmaExampleConstructor >> createExampleFor: aMethodReference [
	| newExample targetPragma |

	newExample := self exampleClass new.
	targetPragma := aMethodReference pragmaAt: self pragmaKeyword.
	targetPragma arguments size = 1 ifTrue: [ 
		newExample title: (targetPragma argumentAt: 1) ].
	^ newExample
]

{ #category : #accessing }
GTPragmaExampleConstructor >> pragmaKeyword [

	^ pragmaKeyword
]

{ #category : #accessing }
GTPragmaExampleConstructor >> pragmaKeyword: aSymbol [

	pragmaKeyword := aSymbol
]
