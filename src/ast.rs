pub enum NodeKind {
    Class,
    Enum,
    Function,
    Method,
    Parameter,
    Property,
    Variable,
}

pub struct FilePosition {
    pub line: usize,
    pub column: usize,
}

pub struct SourceMap {
    pub file_path: String,
    pub start: FilePosition,
    pub end: FilePosition,
}

pub struct Node {
    pub name: String,
    pub kind: NodeKind,
    pub source: SourceMap,
}
