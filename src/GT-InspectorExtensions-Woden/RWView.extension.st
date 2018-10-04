Extension { #name : #RWView }

{ #category : #'*GT-InspectorExtensions-Woden' }
RWView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite morph 
		title: 'Live';
		initialize: [ :m |
			self elements do: [ :e | 
				e when: RWMouseButtonDown do: [ :ev | 
					m selection: ev element model].
			 ].
			"self @ RWMouseKeyControl" ];
		display: [
			(RWViewWindow new view: self) morphicWindow
			]

]
