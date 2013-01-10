module DownloadHelper

	def tablet_models
		[
			300, # Cintiq 20WSX
			301, # Cintiq 12W (DTZ-1200)

			# I4
			321, # Medium
			322, # Large
			323, # XL
			324, # Wireless
			327, # Cintiq 24HD (Osprey Pen)
			328, # Cintiq 24HDT (Osprey Touch)
			330, # Cintiq 22HD (Osprey Pen Value)

			# I5
			335, # Medium Pen
			336, # Small Pen & Touch
			337, # Medium Pen & Touch
			338, # Large Pen & Touch
		]
	end

	def tablet_types
		[
			17, # PTZ USB
			24, # PTK USB
			26, # PTK BT
			27, # WL Receiver
		]
	end
end
