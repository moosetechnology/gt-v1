"
It provides example services:
- extracts examples
- displays examples in the inspector
"
Class {
	#name : #GTExampleProvider,
	#superclass : #Object,
	#instVars : [
		'subject'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #'instance creation' }
GTExampleProvider class >> on: aSubject [
	^ self new subject: aSubject 
]

{ #category : #ui }
GTExampleProvider >> gtDisplayExamplesIn: aComposite [

	^ aComposite tree
		title: 'E.g.';
		when: [ self gtExamples notEmpty ];
		display: [ self gtExamples ];
		children: [ :anExample | anExample childrenExamples ];
		format: [ :anExample | anExample title ];
		send: [ :anExample | anExample result ];
		allExpanded;
		selectionPopulate: #selection 
			on: $o 
			entitled: 'Open source' 
			with: [ :list | list rawSelection methodReference ]
]

{ #category : #accessing }
GTExampleProvider >> gtExamples [
	^ GTExampleExtractionStrategy new rootExamplesFor: self subject
]

{ #category : #accessing }
GTExampleProvider >> subject [
	^ subject
]

{ #category : #accessing }
GTExampleProvider >> subject: anObject [
	subject := anObject
]
