Extension { #name : #Morph }

{ #category : #'*GT-Examples-Examples' }
Morph class >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty'>
	
	^ self new
]

{ #category : #'*GT-Examples-Examples' }
Morph class >> gtExampleSubmorphs [
	<gtExample>
	<label: 'Submorphs'>
	
	^ self new
		addMorph: self new;
		addMorph: self new;
		yourself
]
