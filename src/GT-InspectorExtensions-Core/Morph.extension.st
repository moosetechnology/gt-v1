Extension { #name : #Morph }

{ #category : #'*GT-InspectorExtensions-Core' }
Morph >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 95>
	self kmDispatcher gtInspectorMappingsIn: composite
]

{ #category : #'*GT-InspectorExtensions-Core' }
Morph >> gtInspectorMorphExtensionIn: composite [
	<gtInspectorPresentationOrder: 15>
	^ composite table
		title: 'Extension';
		showOnly: 50; 
		display: [ self extension gtInspectorVariableValuePairs asSortedCollection ];
		column: 'Variable' 
			evaluated: [:assoc | GTObjectPrinter new asNonTruncatedTextFrom: assoc key ];
		column: 'Value' 
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ];
		send: #value;
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect';
		selectionAct: [:list | 
			((list selection pointersToExcept: { list selection })
									reject: [ :each | each pointsOnlyWeaklyTo: list selection ]) inspect ] 
			on: $t
			entitled: 'Open pointers to'
]

{ #category : #'*GT-InspectorExtensions-Core' }
Morph >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 90>  
	| morphPresentation |
	morphPresentation := composite morph.
	morphPresentation 
		title: 'Morph';
		display: [ :each |
			self imageForm asMorph
				on: #mouseDown send: #value: to: [ :event | 
					morphPresentation selection: (self morphsAt: event position) ] ];
		act: [ :pres | self exportAsPNG ] entitled: 'Export as PNG';
		act: [ :pres | self delete ] entitled: 'Delete'
]

{ #category : #'*GT-InspectorExtensions-Core' }
Morph >> gtInspectorSubmorphsIn: composite [
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
