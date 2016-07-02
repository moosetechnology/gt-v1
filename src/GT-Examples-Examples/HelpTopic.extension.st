Extension { #name : #HelpTopic }

{ #category : #'*GT-Examples-Examples' }
HelpTopic class >> gtExampleComposedTopic [
	<gtExample>
	|rootTopic|
	
	rootTopic := HelpTopic new
		title: 'ExampleTopic';
		contents: 'I am an example topic'.
	rootTopic addSubtopic: (HelpTopic new
		title: 'Subtopic1';
		contents: 'I am an subtopic topic').
	rootTopic addSubtopic: (HelpTopic new
		title: 'Subtopic2').
		
	^ rootTopic
		
]

{ #category : #'*GT-Examples-Examples' }
HelpTopic class >> gtExampleSingleTopic [
	<gtExample>
	
	^ HelpTopic new
		title: 'ExampleTopic';
		contents: 'I am an example topic'
		
]
