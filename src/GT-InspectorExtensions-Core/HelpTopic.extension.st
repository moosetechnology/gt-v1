Extension { #name : #HelpTopic }

{ #category : #'*GT-InspectorExtensions-Core' }
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

{ #category : #'*GT-InspectorExtensions-Core' }
HelpTopic class >> gtExampleSingleTopic [
	<gtExample>
	
	^ HelpTopic new
		title: 'ExampleTopic';
		contents: 'I am an example topic'
		
]

{ #category : #'*GT-InspectorExtensions-Core' }
HelpTopic >> gtInspectorActionOpenHelpBrowser [
	<gtInspectorAction>
	
	^ GLMGenericAction new
		action: [ HelpBrowser openOn: self ];
		icon: (HelpIcons iconNamed:#bookIcon);
		title: 'Browse'
]

{ #category : #'*GT-InspectorExtensions-Core' }
HelpTopic >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 40>
	
	composite text
		title: 'Contents';
		display: [ self contents ];
		when: [ self contents notEmpty  ] 
]

{ #category : #'*GT-InspectorExtensions-Core' }
HelpTopic >> gtInspectorSubtopicsIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite tree
		shouldValidate: false;
		title: 'Subtopics';
		display: [ self subtopics ];
		children: [ :each | each subtopics ];
		when: [ self hasSubtopics ];
		format: #title
]
