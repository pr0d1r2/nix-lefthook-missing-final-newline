#!/usr/bin/env bats

setup() {
    load "${BATS_LIB_PATH}/bats-support/load.bash"
    load "${BATS_LIB_PATH}/bats-assert/load.bash"

    TMP="$BATS_TEST_TMPDIR"
}

@test "no args exits 0" {
    run lefthook-missing-final-newline
    assert_success
}

@test "non-existent file is skipped" {
    run lefthook-missing-final-newline /nonexistent/file.txt
    assert_success
}

@test "empty file passes" {
    printf '' > "$TMP/empty.txt"
    run lefthook-missing-final-newline "$TMP/empty.txt"
    assert_success
}

@test "file ending with newline passes" {
    printf 'hello\n' > "$TMP/good.txt"
    run lefthook-missing-final-newline "$TMP/good.txt"
    assert_success
}

@test "file missing final newline fails" {
    printf 'hello' > "$TMP/bad.txt"
    run lefthook-missing-final-newline "$TMP/bad.txt"
    assert_failure
    assert_output --partial "missing final newline"
}

@test "multiple files: one missing newline causes failure" {
    printf 'good\n' > "$TMP/good.txt"
    printf 'bad' > "$TMP/bad.txt"
    run lefthook-missing-final-newline "$TMP/good.txt" "$TMP/bad.txt"
    assert_failure
    assert_output --partial "bad.txt"
}

@test "file with multiple lines ending with newline passes" {
    printf 'line one\nline two\nline three\n' > "$TMP/multi.txt"
    run lefthook-missing-final-newline "$TMP/multi.txt"
    assert_success
}
