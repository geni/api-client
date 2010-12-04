require 'json'

class Family
  attr_accessor :family

  def initialize(family)
    self.family = family.kind_of?(String) ? JSON.parse(family) : family
  end

  def handprint
    %{
      Parents: #{names(:parents)}
      Children: #{names(:children)}
      Partners: #{names(:partners)}
    }
  end

  def names(group)
    send(group).collect do |node|
      "#{node['first_name']} #{node['last_name']}"
    end
  end

  def parents
    walk(focus, ['child', 'partner'])
  end

  def partners
    walk(focus, ['partner', 'partner'])
  end

  def children
    walk(focus, ['partner', 'child'])
  end

  def walk(node, rels)
    node = node(node) if node.kind_of?(String)
    return node if rels.empty?

    rel = rels.shift
    node['edges'].collect do |id, edge|
      if edge['rel'] == rel and id != focus_id 
        walk(id, rels)
      end
    end.compact.flatten
  end

  def node(id)
    family['nodes'][id]
  end

  def focus
    node(focus_id)
  end

  def focus_id
    pid(family['focus']['id'])
  end

  def pid(id)
    "profile-#{id}"
  end

  def uid(id)
    "union-#{id}"
  end
end
