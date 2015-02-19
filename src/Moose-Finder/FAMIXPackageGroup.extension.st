Extension { #name : #FAMIXPackageGroup }

{ #category : #'*moose-finder' }
FAMIXPackageGroup >> mooseFinderDependenciesIn: composite [
	<moosePresentationOrder: 20>
	composite roassal2
			title: 'Dependencies';
			titleIcon: MooseIcons mooseDependencies;
			initializeView: [ RTMondrianViewBuilder new ];
			painting: [ :view :each | 
						each mooseInterestingEntity viewDependenciesWithCyclesOn: view ]
]

{ #category : #'*moose-finder' }
FAMIXPackageGroup >> mooseIcon [
	^ MooseIcons famixPackageGroup 
]
