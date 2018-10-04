Extension { #name : #BlMorph }

{ #category : #'*GT-InspectorExtensions-Bloc' }
BlMorph >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 95>
	self kmDispatcher gtInspectorMappingsIn: composite
]

{ #category : #'*GT-InspectorExtensions-Bloc' }
BlMorph >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 90>  
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: 'Morph';
		display: [
			self imageForm asMorph
				on: #mouseDown send: #value: to: [ :event | 
					morphPresentation selection: (self morphsAt: event position) ] ];
		act: [ :pres | self exportAsPNG ] entitled: 'Export as PNG';
		act: [ :pres | self delete ] entitled: 'Delete'
]

{ #category : #'*GT-InspectorExtensions-Bloc' }
BlMorph >> gtInspectorSubmorphsIn: composite [
	<gtInspectorPresentationOrder: 80>  
	composite tree 
		title: 'Submorphs';
		rootsExpanded;
		display: [:each | {each} ];
		icon: [:each | | morphForm |
			morphForm := each imageForm.
			(morphForm extent x > 0 and: [morphForm extent y > 0 ])
				ifTrue: [(morphForm scaledToSize: 16@16) asMorph]
				ifFalse: [Form extent: 16@16] ];
		children: [:each | each submorphs];
		when: [:each | each submorphs notEmpty ]
]
