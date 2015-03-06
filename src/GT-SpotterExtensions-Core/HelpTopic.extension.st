Extension { #name : #HelpTopic }

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> gtAllSubtopics [
	 ^ self subtopics flatCollect: [:aTopic |
		aTopic asOrderedCollection, aTopic gtAllSubtopics ]
		 
]

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> gtBreadcrumbTitle [
	|breadcrumbTitle currentHelpTopic|
	
	currentHelpTopic := self.	
	breadcrumbTitle:= currentHelpTopic title.
	[ currentHelpTopic owner notNil and: [currentHelpTopic owner owner notNil ] ] whileTrue: [ 
		currentHelpTopic := currentHelpTopic owner.
		breadcrumbTitle := breadcrumbTitle , ' > ', currentHelpTopic title  ].
	^ breadcrumbTitle 
]

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> gtTopicIcon [
	^ (HelpIcons iconNamed: (self hasSubtopics
		 ifTrue: [#bookIcon] 
	    ifFalse: [#pageIcon]))
]

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> spotterForHelpTopicFor: aStep [
	<spotterOrder: 200>
	aStep listProcessor 
		allCandidates: [ self subtopics ];
		title: 'Help contents';
		itemName: [ :helpTopic | helpTopic title ];
		itemIcon: [ :helpTopic | helpTopic gtTopicIcon ];
		filter: (GTFilterBlock new 
			matcher: [ :item :context |				
				(context cacheAt: #queryForHelpTopics ifAbsentPut: [ context textLowercase splitOn: ' ' ])
					 allSatisfy: [ :each | item contents asString includesSubstring: each ] ];
		yourself);
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> spotterPreviewContentHelpIn: aComposite [
	<spotterPreview: 10>
	
	self hasSubtopics ifTrue: [ ^ self ].
	aComposite text
		title: [ self title ];
		display: [:aHelpTopic | 
			aHelpTopic contents];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-SpotterExtensions-Core' }
HelpTopic >> spotterPreviewSubtopicsHelpIn: aComposite [
	<spotterPreview: 15>

	aComposite list
		title: [ self title ];
		display: #yourself;
		format: [ :aHelpTopic | GTSpotterItemBrick new 
				text: aHelpTopic title;
				icon: aHelpTopic gtTopicIcon;
				disable ];
		styled: [ :brick | brick ];
		entity: self subtopics.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
