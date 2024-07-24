module Seam
  class WorkspacesProxy
    def initialize(workspaces)
      @workspaces = workspaces
    end

    def list(**kwargs)
      @workspaces.list(**kwargs)
    end

    def create(**kwargs)
      @workspaces.create(**kwargs)
    end
  end
end
