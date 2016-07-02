Extension { #name : #Dictionary }

{ #category : #'*GT-Examples-Examples' }
Dictionary class >> gtExampleEmptyDictionary [
	<gtExample>
	<label: 'Empty dictionary'>

	^ Dictionary new
]

{ #category : #'*GT-Examples-Examples' }
Dictionary class >> gtExampleOneElementDictionaryFrom: anEmptyDictionary [
	<gtExample>
	<label: 'One element dictionary'>
	<depends: #gtExampleEmptyDictionary>
	
	anEmptyDictionary at: 4 put: 2.
	^ anEmptyDictionary
]

{ #category : #'*GT-Examples-Examples' }
Dictionary class >> gtExampleRemoveElementFrom: anEmptyDictionary [
	<gtExample>
	<label: 'Remove element'>
	<depends: #gtExampleOneElementDictionaryFrom:>
	
	anEmptyDictionary removeKey: 4.
	^ anEmptyDictionary
]

{ #category : #'*GT-Examples-Examples' }
Dictionary class >> gtExampleTwoElementsDictionaryFrom: aDictionary [
	<gtExample>
	<label: 'Two elements dictionary'>
	<depends: #gtExampleOneElementDictionaryFrom:>
	
	aDictionary at: #fourty put: 'two'.
	^ aDictionary
]
