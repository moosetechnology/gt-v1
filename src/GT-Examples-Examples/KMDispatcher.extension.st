Extension { #name : #KMDispatcher }

{ #category : #'*GT-Examples-Examples' }
KMDispatcher class >> gtExampleDispatcherWithTarget [
	<gtExample>
	<label: 'Dispatcher with target'>
	
	^ self target: Morph new
]

{ #category : #'*GT-Examples-Examples' }
KMDispatcher class >> gtExampleDispatcherWithTargetAndShortcuts [
	<gtExample>
	<label: 'Dispatcher with target and shortcuts'>
	
	^ BorderedMorph new kmDispatcher
]

{ #category : #'*GT-Examples-Examples' }
KMDispatcher class >> gtExampleEmptyDispatcher [
	<gtExample>
	<label: 'Empty dispatcher'>
	
	^ self new
]
