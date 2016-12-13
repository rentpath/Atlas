/*
 * Copyright (c) 2016 RentPath, LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

extension Int: AtlasMap {

    public func toJSON() -> JSON? {
        return nil
    }

    public init?(json: JSON) throws {
        guard let _int = Int("\(json)") else {
            throw MappingError.notMappable("Unable to map \(json) to type Int")
        }
        self = _int
    }

}

extension Int8: AtlasMap {

    public func toJSON() -> JSON? {
        return nil
    }

    public init?(json: JSON) throws {
        guard let _int = Int8("\(json)") else {
            throw MappingError.notMappable("Unable to map \(json) to type Int8")
        }
        self = _int
    }

}

extension Int16: AtlasMap {

    public func toJSON() -> JSON? {
        return nil
    }

    public init?(json: JSON) throws {
        guard let _int = Int16("\(json)") else {
            throw MappingError.notMappable("Unable to map \(json) to type Int16")
        }
        self = _int
    }

}

extension Int32: AtlasMap {

    public func toJSON() -> JSON? {
        return nil
    }

    public init?(json: JSON) throws {
        guard let _int = Int32("\(json)") else {
            throw MappingError.notMappable("Unable to map \(json) to type Int32")
        }
        self = _int
    }

}

extension Int64: AtlasMap {

    public func toJSON() -> JSON? {
        return nil
    }

    public init?(json: JSON) throws {
        guard let _int = Int64("\(json)") else {
            throw MappingError.notMappable("Unable to map \(json) to type Int64")
        }
        self = _int
    }

}
