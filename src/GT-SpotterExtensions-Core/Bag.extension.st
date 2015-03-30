Extension { #name : #Bag }

{ #category : #'*GT-SpotterExtensions-Core' }
Bag class >> exampleBagWithOneElement [
	<gtExample>
	^ Bag with: 42
]

{ #category : #'*GT-SpotterExtensions-Core' }
Bag class >> exampleBagWithTenElements [
	<gtExample>
	^ #(1 2 3 1 2 3 3 4 5 3) asBag
]

{ #category : #'*GT-SpotterExtensions-Core' }
Bag class >> exampleEmptyBag [
	<gtExample>
	^ Bag new
]
