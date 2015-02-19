Extension { #name : #FAMIXNamespaceGroup }

{ #category : #'*moose-finder' }
FAMIXNamespaceGroup >> mooseFinderDependenciesIn: composite [
	<moosePresentationOrder: 20>
	composite roassal2
			title: 'Dependencies';
			titleIcon: MooseIcons mooseDependencies;
			initializeView: [ RTMondrianViewBuilder new ];
			painting: [ :view :each |
				each mooseInterestingEntity viewDependenciesWithCyclesOn: view ]
]

{ #category : #'*moose-finder' }
FAMIXNamespaceGroup >> mooseIcon [
	^ MooseIcons famixNamespaceGroup 
]
