Class {
	#name : #GTExampleHelp,
	#superclass : #CustomHelp,
	#category : #'GT-Examples-Core'
}

{ #category : #accessing }
GTExampleHelp class >> bookName [ 
	^'GT Examples'
]

{ #category : #accessing }
GTExampleHelp class >> key [
	^ self name
]

{ #category : #accessing }
GTExampleHelp class >> pages [ 
	^ #( pragmas )
]

{ #category : #documentation }
GTExampleHelp class >> pragmas [
	^ HelpTopic 
		title: 'Pragmas'
		contents: self pragmasContents
		yourself
]

{ #category : #documentation }
GTExampleHelp class >> pragmasContents [
	^ String streamContents: [ :stream |
		((Pragma allNamed: #gtExamplePragma in: GTExample) 
			sort: [ :a :b | a method selector <= b method selector ]) 
			do: [ :each |
				stream nextPutAll: '<'.
				stream nextPutAll: (each method sourceCode copyUpTo: Character cr).
				stream nextPutAll: '>'.
				stream cr.
				each method pragmas do: [ :pragma | 
					pragma == each ifFalse: [ 
						stream nextPutAll: (String streamContents: [ :argStream |
							pragma arguments 
								do: [ :arg | argStream nextPutAll: arg asString ]
								separatedBy: [ argStream cr ] ]) ] ].
				stream cr; cr ] ]
]
