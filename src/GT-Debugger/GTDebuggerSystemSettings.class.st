Class {
	#name : #GTDebuggerSystemSettings,
	#superclass : #Object,
	#category : #'GT-Debugger'
}

{ #category : #'as yet unclassified' }
GTDebuggerSystemSettings class >> debugSettingsOn: aBuilder [
	<systemsettings>
	
	(aBuilder setting: #enableStackColoring)
		label: 'Color the stack' translated;
		target: GTGenericStackDebugger;
		parent: #debugging;
		description:
				'When true, the stack context are colored based on their relationship with the selected context.' translated
]
