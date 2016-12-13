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

public protocol AtlasMapExecutor {

    var dateMappingExecutor: AtlasDateMappingExecutor? { get }

    /**
     Used to map a top-level JSON object to an instance of `T`
     */
    func object<T: AtlasMap>(_ object: [String: JSON]?) throws -> T?

    /**
     Used to map a top-level JSON array to an instance of `[T]`
     */
    func array<T: AtlasMap>(_ array: [JSON]?) throws -> [T]?

    /**
     Used to map the value of `key` within `json` to an instance of `T`
     */
    func object<T: AtlasMap>(for key: String, from json: [String: JSON]?) throws -> T

    /**
     Used to map the value of `key` within `json` to an instance of `[T]`
     */
    func array<T: AtlasMap>(for key: String, from json: [String: JSON]?) throws -> [T]

    /**
     Used to map the value of `key` within `json` to an instance of `T`
     */
    func object<T: AtlasMap>(forOptional key: String, from json: [String: JSON]?) throws -> T?

    /**
     Used to map the value of `key` within `json` to an instance of `[T]`
     */
    func array<T: AtlasMap>(forOptional key: String, from json: [String: JSON]?) throws -> [T]?

}
