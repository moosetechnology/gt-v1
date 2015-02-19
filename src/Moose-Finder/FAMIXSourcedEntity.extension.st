Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Moose-Finder' }
FAMIXSourcedEntity >> mooseFinderSourceTextIn: composite [
	<moosePresentationOrder: 10>
	composite text
			title: 'Source';
			titleIcon: MooseIcons mooseSourceText;
			format: [ self mooseInterestingEntity formattedSourceText ];
			when: [ self mooseInterestingEntity sourceText notEmpty ]
]

{ #category : #'*Moose-Finder' }
FAMIXSourcedEntity >> spotterPreviewSourceIn: composite [
	<spotterPreview: 0>
	composite text 
		title: [ self mooseName ];
		display: #yourself;
		entity: self sourceText
]
