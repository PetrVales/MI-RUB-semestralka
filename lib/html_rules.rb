require_relative "element"
require_relative "mark"

class HtmlRules

  HEADINGS = [:h1, :h2, :h3, :h4, :h5, :h6]
  INLINE = [:a, :b, :cite, :i, :img, :input, :label, :select, :span, :strong, :sup, :sub, :textarea, :br]
  BLOCK = [:div, :form, :ol, :p, :table, :ul] + HEADINGS
  RULES = {
      :html => [:head, :body],
      :head => [:title, :meta, :style, :script, :link],
      :body => [:script] + BLOCK + INLINE,
      :a => INLINE,
      :b => INLINE,
      :cite => INLINE,
      :i => INLINE,
      :label => INLINE,
      :span => INLINE,
      :strong => INLINE,
      :sup => INLINE,
      :sub => INLINE,
      :div => BLOCK + INLINE,
      :p => BLOCK + INLINE,
      :form => BLOCK + INLINE,
      :ol => [:li],
      :ul => [:li],
      :table => [:thead, :tbody, :tfoot, :caption],
      :thead => [:tr],
      :tbody => [:tr],
      :tfoot => [:tr],
      :tr => [:th, :td],
      :li => INLINE,
      :h1 => [:a]
  }
  CDATA = [:th, :td, :li, :caption, :form, :div, :strong, :span, :label, :i, :cite, :b, :a, :body, :textarea,:sup, :sub, :p, :title, :script] + HEADINGS
  COMMON_ATTRS = [:id, :class, :style]
  ATTRIBUTE = {
    :a => [:href, :rel, :tabindex, :title] + COMMON_ATTRS,
    :body => [:onload] + COMMON_ATTRS,
    :img => [:src, :alt, :height, :width, :title] + COMMON_ATTRS,
    :form => [:action, :method, :onsubmit, "accept-charset".to_sym] + COMMON_ATTRS,
    :label => [:for] + COMMON_ATTRS,
    :input => [:type, :name, :value, :checked, :disabled, :readonly, :maxlength, :tabindex, :size, :title] + COMMON_ATTRS,
    :textarea => [:cols, :rows, :tabindex] + COMMON_ATTRS,
    :table => [:summary] + COMMON_ATTRS,
    :th => [:colspan, :rowspan] + COMMON_ATTRS,
    :tr => [:colspan, :rowspan] + COMMON_ATTRS,
    :script => [:src, :type],
    :style => [:media, :type],
    :meta => [:name, :content, :schema, "http-equiv".to_sym, :charset],
    :link => [:rel, :type, :title, :href, :media],
    :p => COMMON_ATTRS, :span => COMMON_ATTRS, :div => COMMON_ATTRS, :strong => COMMON_ATTRS, :i => COMMON_ATTRS,
    :b => COMMON_ATTRS, :ol => COMMON_ATTRS, :il => COMMON_ATTRS, :li => COMMON_ATTRS, :ul => COMMON_ATTRS
  }

  def checkChildAllowed(parent, child)
    if child.isComment then
      return true
    end
    if child.isCData and CDATA.include?(parent.getName) then
      return true
    end
    if child.isMark and parent.getName == child.getName and parent.isOpen and child.isClose then
      return true
    elsif child.isMark and RULES.key?(parent.getName) and RULES[parent.getName].include?(child.getName) then
      return true
    end
    #puts "parent: #{parent.getName} child: #{child.getName}"
    false
  end

  def checkAttributes(node)
    if node.isMark then
        node.getAttributes.each { |attr|
          if not ATTRIBUTE.key?(node.getName) or not ATTRIBUTE[node.getName].include?(attr) then
            #puts "node: #{node.getName} attr: #{attr}"
            return false
        end
      }
    end
    true
  end
end