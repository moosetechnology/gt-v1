Extension { #name : #RWView }

{ #category : #'*GT-InspectorExtensions-Woden' }
RWView >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite morph 
		title: 'Live';
		initialize: [ :m | 
			self elements do: [ :e | 
				e on: RWMouseButtonDown do: [ :ev | 
					m selection: ev element model].
			 ].
			self @ RWMouseKeyControl ];
		display: [
			(RWViewWindow new view: self ) window
			]

]
