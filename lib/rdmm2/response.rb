# coding: utf-8
module RDMM2
  class Response

    def initialize(doc)
      @doc = doc
    end

    def inspect
      @doc.inspect
    end

    def to_s
      @doc.to_s
    end

    def to_a
      @doc.to_a.map{|v| RDMM2::Response.new(v)}
    end

    def size
      @doc.size
    end

    def each(&block)
      @doc.each do |elem|
        yield RDMM2::Response.new(elem)
      end
    end

    def [](elem_name)
      elem = @doc.css("> #{elem_name}")
      if elem.children.size == 1 && elem.children.first.text?
        elem.text
      else
        RDMM2::Response.new(elem)
      end
    end

    def method_missing(elem_name)
      self[elem_name]
    end

  end
end
