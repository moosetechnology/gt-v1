Extension { #name : #SequenceableCollection }

{ #category : #'*GT-Examples-Core' }
SequenceableCollection >> gtExampleSubstrings [
	^ (self gather: [ :each | each gtExampleSubstrings ])
		reject: [ :each | each isEmptyOrNil ]
]
