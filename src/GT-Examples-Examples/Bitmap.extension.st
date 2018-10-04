Extension { #name : #Bitmap }

{ #category : #'*GT-Examples-Examples' }
Bitmap class >> gtExampleIconBits [
	<gtExample>
	<label: 'Icon bits'>
	^ (Smalltalk ui icons iconNamed: #pharoIcon) bits
]
