// Copyright (c) 2017 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/jballerina.java;

# WritableByteChannel represents an output resource (i.e file) which could be used to sink bytes
# A file path can be used to obtain a `io:WritableByteChannel`.
# A `io:WritableByteChannel` can only be obtained using the following method or by providing a native implementation.
# It cannot be instantiated.
# `io:openWritableFile("./files/sample.txt")` - used to obtain a `io:WritableByteChannel` from a given file path
public class WritableByteChannel {

    # Adding default init function to prevent object getting initialized from the user code.
    isolated function init() {
    }

    # Sinks bytes from a given input/output resource.
    #
    # This is an asynchronous operation. The method might return before writing all the content.
    # ```ballerina
    # int|io:Error result = writableByteChannel.write(record, 0);
    # ```
    #
    # + content - Block of bytes to be written
    # + offset - Offset of the provided content, which needs to be kept when writing bytes
    # + return - Number of bytes written or else `io:Error`
    public isolated function write(byte[] content, int offset) returns int|Error {
        return byteWriteExtern(self, content, offset);
    }

    # Closes a given byte channel.
    # After a channel is closed, any further writing operations will cause an error.
    # ```ballerina
    # io:Error err = writableByteChannel.close();
    # ```
    #
    # + return - `io:Error` or else `()`
    public isolated function close() returns Error? {
        return closeWritableByteChannelExtern(self);
    }
}

isolated function byteWriteExtern(WritableByteChannel byteChannel, byte[] content, int offset) returns int|Error = @java:Method {
    name: "write",
    'class: "org.ballerinalang.stdlib.io.nativeimpl.ByteChannelUtils"
} external;

isolated function closeWritableByteChannelExtern(WritableByteChannel byteChannel) returns Error? = @java:Method {
    name: "closeByteChannel",
    'class: "org.ballerinalang.stdlib.io.nativeimpl.ByteChannelUtils"
} external;
