Extension { #name : #RBBasicLintRule }

{ #category : #'*GT-SpotterExtensions-Core' }
RBBasicLintRule >> hasCriticsResults [
	^ self class isVisible 
		and: [ self isTransformationRule not
			and: [ self problemCount > 0 ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
RBBasicLintRule >> spotterActDefault [
	" #withClassesFixedForNautilus: Nautilus UI cannot browse a metaclass if the class is not within the environment. The checkbox is only a show/hide-toggle between class and metaclass. Previous browsers could do that. Not an RB problem, but we have to fix it there. "
	self hasCriticsResults ifFalse: [ ^ super spotterActDefault ].
	(self result withClassesFixedForNautilus browse) ui title: self name
]

{ #category : #'*GT-SpotterExtensions-Core' }
RBBasicLintRule >> spotterCriticsFor: aStep [
	<spotterOrder: 90>
	self hasCriticsResults ifFalse: [ ^ self ].
	aStep listProcessor
		title: self name;
		items: [ self result smallLintCritics asArray ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
RBBasicLintRule >> spotterCriticsPreviewIn: aComposite [
	<spotterPreview: 10>
	self hasCriticsResults ifFalse: [ ^ self ].
	aComposite text
		title: 'Problems';
		display: [ 
			String streamContents: [ :stream | 
				self result smallLintCritics do: [ :each | 
					each printOn: stream. 
					stream cr ] ] ];
		entity: self.
]
