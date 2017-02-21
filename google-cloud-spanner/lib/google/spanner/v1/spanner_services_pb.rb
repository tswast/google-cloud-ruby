# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/spanner/v1/spanner.proto for package 'google.spanner.v1'
# Original file comments:
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'grpc'
require 'google/spanner/v1/spanner_pb'

module Google
  module Spanner
    module V1
      module Spanner
        # Cloud Spanner API
        #
        # The Cloud Spanner API can be used to manage sessions and execute
        # transactions on data stored in Cloud Spanner databases.
        class Service

          include GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'google.spanner.v1.Spanner'

          # Creates a new session. A session can be used to perform
          # transactions that read and/or modify data in a Cloud Spanner database.
          # Sessions are meant to be reused for many consecutive
          # transactions.
          #
          # Sessions can only execute one transaction at a time. To execute
          # multiple concurrent read-write/write-only transactions, create
          # multiple sessions. Note that standalone reads and queries use a
          # transaction internally, and count toward the one transaction
          # limit.
          #
          # Cloud Spanner limits the number of sessions that can exist at any given
          # time; thus, it is a good idea to delete idle and/or unneeded sessions.
          # Aside from explicit deletes, Cloud Spanner can delete sessions for
          # which no operations are sent for more than an hour, or due to
          # internal errors. If a session is deleted, requests to it
          # return `NOT_FOUND`.
          #
          # Idle sessions can be kept alive by sending a trivial SQL query
          # periodically, e.g., `"SELECT 1"`.
          rpc :CreateSession, CreateSessionRequest, Session
          # Gets a session. Returns `NOT_FOUND` if the session does not exist.
          # This is mainly useful for determining whether a session is still
          # alive.
          rpc :GetSession, GetSessionRequest, Session
          # Ends a session, releasing server resources associated with it.
          rpc :DeleteSession, DeleteSessionRequest, Google::Protobuf::Empty
          # Executes an SQL query, returning all rows in a single reply. This
          # method cannot be used to return a result set larger than 10 MiB;
          # if the query yields more data than that, the query fails with
          # a `FAILED_PRECONDITION` error.
          #
          # Queries inside read-write transactions might return `ABORTED`. If
          # this occurs, the application should restart the transaction from
          # the beginning. See [Transaction][google.spanner.v1.Transaction] for more details.
          #
          # Larger result sets can be fetched in streaming fashion by calling
          # [ExecuteStreamingSql][google.spanner.v1.Spanner.ExecuteStreamingSql] instead.
          rpc :ExecuteSql, ExecuteSqlRequest, ResultSet
          # Like [ExecuteSql][google.spanner.v1.Spanner.ExecuteSql], except returns the result
          # set as a stream. Unlike [ExecuteSql][google.spanner.v1.Spanner.ExecuteSql], there
          # is no limit on the size of the returned result set. However, no
          # individual row in the result set can exceed 100 MiB, and no
          # column value can exceed 10 MiB.
          rpc :ExecuteStreamingSql, ExecuteSqlRequest, stream(PartialResultSet)
          # Reads rows from the database using key lookups and scans, as a
          # simple key/value style alternative to
          # [ExecuteSql][google.spanner.v1.Spanner.ExecuteSql].  This method cannot be used to
          # return a result set larger than 10 MiB; if the read matches more
          # data than that, the read fails with a `FAILED_PRECONDITION`
          # error.
          #
          # Reads inside read-write transactions might return `ABORTED`. If
          # this occurs, the application should restart the transaction from
          # the beginning. See [Transaction][google.spanner.v1.Transaction] for more details.
          #
          # Larger result sets can be yielded in streaming fashion by calling
          # [StreamingRead][google.spanner.v1.Spanner.StreamingRead] instead.
          rpc :Read, ReadRequest, ResultSet
          # Like [Read][google.spanner.v1.Spanner.Read], except returns the result set as a
          # stream. Unlike [Read][google.spanner.v1.Spanner.Read], there is no limit on the
          # size of the returned result set. However, no individual row in
          # the result set can exceed 100 MiB, and no column value can exceed
          # 10 MiB.
          rpc :StreamingRead, ReadRequest, stream(PartialResultSet)
          # Begins a new transaction. This step can often be skipped:
          # [Read][google.spanner.v1.Spanner.Read], [ExecuteSql][google.spanner.v1.Spanner.ExecuteSql] and
          # [Commit][google.spanner.v1.Spanner.Commit] can begin a new transaction as a
          # side-effect.
          rpc :BeginTransaction, BeginTransactionRequest, Transaction
          # Commits a transaction. The request includes the mutations to be
          # applied to rows in the database.
          #
          # `Commit` might return an `ABORTED` error. This can occur at any time;
          # commonly, the cause is conflicts with concurrent
          # transactions. However, it can also happen for a variety of other
          # reasons. If `Commit` returns `ABORTED`, the caller should re-attempt
          # the transaction from the beginning, re-using the same session.
          rpc :Commit, CommitRequest, CommitResponse
          # Rolls back a transaction, releasing any locks it holds. It is a good
          # idea to call this for any transaction that includes one or more
          # [Read][google.spanner.v1.Spanner.Read] or [ExecuteSql][google.spanner.v1.Spanner.ExecuteSql] requests and
          # ultimately decides not to commit.
          #
          # `Rollback` returns `OK` if it successfully aborts the transaction, the
          # transaction was already aborted, or the transaction is not
          # found. `Rollback` never returns `ABORTED`.
          rpc :Rollback, RollbackRequest, Google::Protobuf::Empty
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end