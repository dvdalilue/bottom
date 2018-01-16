#!/usr/bin/env ruby

module DFS
    def dfs start, visited=[]
        q = [start]
        while !q.empty?
            current = q.pop
            if !visited.include? current
                current.each_nbr { |neighbor| q.push neighbor }
                visited << current
                yield current
            end
        end
    end

    def reachs to
        dfs(self) { |n| return true if n == to }

        false
    end

    def reached by
        dfs(by) { |n| return true if n == self }

        false
    end
end

class Node
    include DFS

    attr_reader :value
    attr_reader :neighbors

    def initialize v
        @value = v
        @neighbors = []
    end

    def add_edge_to node
        @neighbors << node
    end

    def each_nbr
        @neighbors.each { |e| yield e }
    end

    def to_s
        print "node #{@value}: "

        if !@neighbors.empty?
            (@neighbors.map(&:value).map { |n| n.to_s + " " }).inject(:+)
        else
            ""
        end
    end
end

class Graph
    attr_reader :ns, :es

    def initialize ns, es
        @nodes = Array::new(ns) { |i| Node::new i }
        @ns = ns
        @es = es
    end

    def add_edge f, t
        @nodes[f].add_edge_to @nodes[t]
    end

    def edges n
        @nodes[n].neighbors
    end

    def [] n
        @nodes[n]
    end

    def bottom
        sinks = []

        (0..@ns-1).each do |i|
            (0..@ns-1).each do |j|
                break if !self[j].reachs self[i]

                sinks.push i unless j != @ns - 1 
            end
        end

        sinks
    end

    def to_s
        @nodes.each do |n|
            puts n
        end
        ""
    end
end

input = STDIN.read.lines

test_case = 0

input.each_slice(2) do |test_case|
    g_input = test_case[0].split.map &:to_i

    exit if g_input[0] == 0

    edges = test_case[1].split.each_slice(2).to_a.map { |e| e.map &:to_i }

    graph = Graph.new g_input[0], g_input[1]


    edges.each { |e| graph.add_edge e[0]-1, e[1]-1 }
    
    graph.bottom.map { |s| print "#{s+1} " }
    
    puts ""
end