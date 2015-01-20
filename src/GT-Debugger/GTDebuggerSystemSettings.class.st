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
				'When true, the stack context are colored based on their relationship with the selected context.' translated.
	
	(aBuilder setting: #enableDebuggerWindowDistinctColor)
		label: 'Color the window' translated;
		target: GTGenericStackDebugger;
		parent: #debugging;
		description:
				'When true, the window border is colored with red to make it distinct from other windows.' translated.
	

]
