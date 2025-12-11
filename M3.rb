use_bpm 150

define :intro_hook do
  use_synth :sine
  notes = [:e5, :g5, :a5, :g5, :e5, :d5, :c5, :d5]
  notes.each do |n|
    play n, release: 0.3, amp: 1.2
    sleep 0.5   # 8 notes = 4 beats
  end
  
  sleep 4       # 4 more beats = 1 bar of space
end

live_loop :chorus_lead do
  sync :chorus_section
  use_synth :saw
  
  melody = [:e4, :g4, :a4, :g4, :e4, :d4, :c4, :d4]
  
  with_fx :reverb, mix: 0.4 do
    melody.each do |n|
      play n, release: 0.3, amp: 1.4
      sleep 0.5
    end
  end
  
  sleep 8
end

live_loop :chorus_arp do
  sync :chorus_section
  use_synth :blade
  
  notes = chord(:c5, :major7)
  
  # Iterate the arp 4 times
  4.times do
    with_fx :echo, phase: 0.25, decay: 3 do
      play notes.choose, release: 0.25, amp: 0.7
      sleep 0.25
    end
  end
  
  sleep 8
end

live_loop :chorus_pad do
  sync :chorus_section
  use_synth :hollow
  
  with_fx :reverb, mix: 0.6, room: 0.8 do
    play_chord chord(:c4, :major), sustain: 8, amp: 0.3
  end
  
  sleep 8
end

live_loop :chorus_rhythm do
  sync :chorus_section
  
  with_fx :distortion, distort: 0.3 do
    8.times do
      sample :elec_click, amp: 0.6
      sleep 0.5
    end
  end
  
  sleep 8
end

live_loop :chords do
  use_synth :piano
  play_chord chord(:c4, :major), sustain: 3, release: 1
  sleep 4
  play_chord chord(:g3, :major), sustain: 3, release: 1
  sleep 4
  play_chord chord(:a3, :minor), sustain: 3, release: 1
  sleep 4
  play_chord chord(:f3, :major), sustain: 3, release: 1
  sleep 4
end


live_loop :drums do
  sample :bd_haus, amp: 2
  sleep 1
  sample :sn_dub, amp: 1.2
  sleep 1
end

live_loop :hats do
  sample :drum_cymbal_closed, amp: 0.6
  sleep 0.5
end

# BFS
verse1 = [
  "Breadth-first goes level by level,",
  "Neighbors of the source we visit every fellow.",
  "Then we go on to the neighbors of those,",
  "Step by step we're expanding our nodes.",
  "Closest nodes first, is the order we keep,",
  "Queue in the front so the spacing stays neat.",
  "Mark ‘em as read to avoid any cycles,",
  "Finding shortest paths like Dijkstra’s disciple."
]

#CHORUS
chorus = [
  "B-F-S goes wide, D-F-S dives deep,",
  "Two different ways our algorithms sweep.",
  "Queue for the breadth, stack for the depth,",
  "Both explore the graph with every single step.",
  "Level by level or a long straight line",
  "Both find the truth in their own design.",
  "B-F-S goes wide, D-F-S dives deep,",
  "Two ways to search the paths we keep."
]

# DFS
verse2 = [
  "Depth-first starts at the source and goes down,",
  "Follow one path till no more edges found.",
  "Hit a dead end? Time to backtrack slow,",
  "Try a new direction where the edges can go.",
  "Mark every node so we don’t repeat,",
  "Order of neighbors makes the journey unique.",
  "Many traversals based on where we begin,",
  "Stack in our hands, that’s how we dive in."
]

live_loop :lyrics do
  # Only run intro once
  if tick(:lyrics_intro) == 0
    intro_hook
    sleep 4
  end
  
  # VERSE 1
  verse1.each do |line|
    puts line
    sleep 8
  end
  sleep 8
  
  # CHORUS
  cue :chorus_section
  chorus.each do |line|
    puts line
    sleep 8
  end
  sleep 12
  
  # VERSE 2
  verse2.each do |line|
    puts line
    sleep 8
  end
  sleep 8
  
  # CHORUS AGAIN
  cue :chorus_section
  chorus.each do |line|
    puts line
    sleep 8
  end
  sleep 16
end
