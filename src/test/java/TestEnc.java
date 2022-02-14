/*
 * @(#)TestEnc.java     2022-01-28(028) 오후 4:59
 *
 * Copyright 2022 JAYU.space
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import org.junit.Test;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;


/**
 * <b>Description</b>
 * <pre>
 * </pre>
 *
 * @author 양기화(梁起華 Yang, Ki Hwa)
 */
public class TestEnc {

    MessageDigestPasswordEncoder messageDigestPasswordEncoder = new MessageDigestPasswordEncoder("SHA-256");


    @Test
    public void name() {
        PasswordEncoder passwordEncoder = new MessageDigestPasswordEncoder("SHA-256");
        String org = "dev!@#123Pwd";
        org = "*plear2323";
        String enc = passwordEncoder.encode(org);
        System.out.println("enc............"+ enc);

        enc = "666fe169900292ce375138be5e8a68d4cb2e39075b359fc1b1c2f4f8fa5bbab8";


        System.out.println("org............"+ org);
        System.out.println("enc............"+ enc);
        System.out.println("match.........."+ passwordEncoder.matches(org, enc));

    }
}
